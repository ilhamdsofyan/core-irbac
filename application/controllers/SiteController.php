<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class SiteController extends CI_Controller {

	public function __construct()
	{
		parent::__construct();

		$this->load->model([
			'forms/formlogin',
			'transaksi/userdetail',
		]);
	}

	public function actionIndex()
	{
		$this->layout->layout = 'main';
		$this->layout->view_js = '_partial/index_js';
		$this->layout->view_css = '_partial/index_css';
		$this->layout->render('index', []);
	}

	public function actionLogin()
	{
		$this->layout->layout = 'login';
		$this->layout->title = 'Login';

		if ($post = $this->input->post()) {
			$this->formlogin->setAttributes($post);
			
			if ($this->formlogin->login()) {
				return redirect('/site','refresh');
			}
		}

		$this->layout->render('login', [
			'model' => $this->formlogin,
			'google_url' => $this->helpers->getUrlGoogle()
		]);
	}

	public function actionLogout()
	{
		$user_data = $this->session->all_userdata();
		foreach ($user_data as $key => $value) {
			if ($key != 'session_id' && $key != 'ip_address' && $key != 'user_agent' && $key != 'last_activity') {
				$this->session->unset_userdata($key);
			}
		}

		$this->session->sess_destroy();
		return redirect('/site/login');
	}

	public function actionLock()
	{
		if ($this->session->userdata('status_login') != 'locked') {
			$this->session->set_userdata(['status_login' => 'locked']);
		}

		$this->layout->layout = 'login';
		$this->layout->title = 'Login';

		if ($post = $this->input->post()) {
			$this->formlogin->setAttributes($post);
			
			if ($this->formlogin->unlock()) {
				return redirect('/site','refresh');
			}
		}

		$this->layout->render('lock', [
			'model' => $this->formlogin,
		]);
	}

	public function actionGoogleAuth()
	{
		// google API Configuration
		$client = $this->helpers->configGoogle();

		if (empty($_GET['code'])) {
			$auth_url = $client->createAuthUrl();

			redirect($auth_url,'refresh');
		} else {
			$authenticate = $client->authenticate($_GET['code']);

			if (!empty($authenticate)) {
				$this->session->set_userdata(['google_access_token' => $authenticate]);

				$user = $client->verifyIdToken($authenticate['id_token']);
				if (!empty($user['email'])) {
					if ($this->formlogin->loginGoogle($authenticate, $user)) {
						return redirect('/site', 'refresh');
					} else {
						$this->session->set_flashdata('message', 'Maaf akun Google dengan alamat Email <b>'. $user['email'] .'</b> 
							tidak ditemukan pada sistem');
					}

				} else {
					$this->session->set_flashdata('message', 'Harap konfirmasi Email anda');
				}

			} else {
				$this->session->set_flashdata('message', 'Proses login kedaluwarsa, mohon lakukan login kembali');
			}
		}

		return redirect('/site/login', 'refresh');
	}
}

/* End of file SiteController.php */
/* Location: ./application/controllers/SiteController.php */