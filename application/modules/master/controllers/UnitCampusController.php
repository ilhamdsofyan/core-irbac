<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class UnitCampusController extends CI_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->model([
			'master/UnitCampus',
		]);
	}

	public function actionIndex()
	{
		$this->layout->title = 'Master Unit Campus';
		$this->layout->view_js = 'ext/index_js';
		$this->layout->view_css = 'ext/index_css';

		$this->layout->render('index', []);
	}

	public function actionGetData()
	{
		if (!$this->input->is_ajax_request()) {
			show_error('Halaman tidak valid', 404);exit();
		}

		$model = new UnitCampus;
		$list = $model->get_datatables();
        $data = [];
        $no = $_POST['start'];

        foreach ($list as $field) {
            $no++;
            $row = [];
            $row[] = $no;
            $row[] = $field->unit_id;
            $row[] = $field->unit_name;
            $row[] = $field->unit_parent_id;
            $row[] = $field->unit_level;
            $row[] = $field->unit_status;
            $row[] = $field->unit_kerjasama;
            $row[] = $field->unit_type;
            $row[] = "
            	<div class='text-center'>
            		". anchor("/master/unit-campus/detail/{$field->id}", "<i class='fa fa-eye'></i>", ['class' => 'btn-normal btn-info btn-xs']) ."
            		". anchor("/master/unit-campus/update/{$field->id}", "<i class='fa fa-pencil-alt'></i>", ['class' => 'btn-normal btn-warning btn-xs']) ."
            		". anchor("/master/unit-campus/delete/{$field->id}", "<i class='fa fa-trash-alt'></i>", ['class' => 'btn-normal btn-danger btn-xs']) ."
            	</div>
            ";
 
            $data[] = $row;
        }
 
        $output = array(
            "draw" => $_POST['draw'],
            "recordsTotal" => $model->count_all(),
            "recordsFiltered" => $model->count_filtered(),
            "data" => $data,
        );

        //output dalam format JSON
        echo json_encode($output);
	}

}

/* End of file UnitCampusController.php */
/* Location: ./application/modules/master/controllers/UnitCampusController.php */