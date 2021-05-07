<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

class UnitCampus extends MY_Model {

	public $tableName = 'unit_campus';
	public $datatable_columns = ['unit_id', 'unit_name', 'unit_parent_id', 'unit_level', 'unit_status', 'unit_kerjasama', 'unit_type'];
	public $datatable_search = ['unit_id', 'unit_name', 'unit_parent_id', 'unit_level', 'unit_status', 'unit_kerjasama', 'unit_type'];
    public $blameable = true;
    public $timestamps = true;
    public $soft_delete = false;

    public function blameableBehavior()
    {
        return [
            'createdByAttribute' => 'created_by',
            'updatedByAttribute' => 'updated_by',
            'value' => def($this->session->userdata('identity'), 'id')
        ];
    }

}