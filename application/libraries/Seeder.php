<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Seeder
{
    /** @var CI_Controller */
    protected $CI;

    public function __construct()
    {
        $this->CI =& get_instance();
        $this->CI->load->database();
    }

    /**
     * @param string $seeder
     * @return void
     */
    public function call($seeder)
    {
        $path = APPPATH . 'seeders/' . $seeder . '.php';

        if (!is_file($path)) {
            show_error('Seeder tidak ditemukan: ' . $seeder, 500);
        }

        require_once $path;

        $instance = new $seeder();

        if (!method_exists($instance, 'run')) {
            show_error('Method run() tidak ditemukan pada seeder: ' . $seeder, 500);
        }

        $instance->run();
    }
}
