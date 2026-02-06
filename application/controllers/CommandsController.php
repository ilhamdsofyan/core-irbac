<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class CommandsController extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();

        if (!$this->input->is_cli_request()) {
            show_error('Endpoint ini hanya bisa dijalankan melalui CLI.', 403);
        }

        $this->load->database();
    }

    public function actionMigrate()
    {
        $this->config->set_item('migration_enabled', TRUE);
        $this->load->library('migration');

        if ($this->migration->latest() === false) {
            echo 'Migration gagal: ' . $this->migration->error_string() . PHP_EOL;
            return;
        }

        echo 'Migration berhasil dijalankan ke versi terbaru.' . PHP_EOL;
    }

    public function actionSeed()
    {
        $this->load->library('Seeder');
        $this->seeder->call('InitialSeeder');

        echo 'Seeder InitialSeeder berhasil dijalankan.' . PHP_EOL;
    }

    public function actionMigrateAndSeed()
    {
        $this->actionMigrate();
        $this->actionSeed();

        echo 'Migration + seeder selesai.' . PHP_EOL;
    }
}
