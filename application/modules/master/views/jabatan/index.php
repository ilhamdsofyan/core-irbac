<h1 class="page-title"><?= $title ?></h1>

<div class="row">
    <div class="col-md-12">
        <div class="card light bordered">
            <div class="card-body">
            	<div class="table-toolbar">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="btn-group mb-3">
                                <button id="btn-add" class="btn sbold btn-primary"> Tambah
                                    <i class="fa fa-plus"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

            	<table class="table table-striped table-bordered table-hover dt-responsive" width="100%" id="table-jabatan">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Kode Jabatan</th>
                            <th>Nama Jabatan</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal fade draggable-modal" id="draggable" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Modal Title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
            	<fieldset id="field-multiple">
	        		<?= form_open('/master/jabatan/tambah', ['id' => 'form-multiple']); ?>

	        			<div class="form-group mt-repeater">
                            <div data-repeater-list="Jabatan">
                                <div data-repeater-item class="mt-repeater-item">
                                    <div class="row mt-repeater-row">
                                        <div class="col-md-4">
                                        	<?= form_label('Kode Jabatan'); ?>
                                        	<?= form_input('kode_jabatan', '', [
                                        		'class' => 'form-control',
                                        	]); ?>
                                        </div>
                                        <div class="col-md-7">
                                            <?= form_label('Nama Jabatan'); ?>
                                        	<?= form_input('nama_jabatan', '', [
                                        		'class' => 'form-control',
                                        	]); ?>
                                        </div>
                                        <div class="col-md-1">
                                            <?= form_label(''); ?>
                                            <a href="javascript:;" data-repeater-delete class="btn btn-danger mt-repeater-delete mt-2">
                                                <i class="fa fa-times"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <a href="javascript:;" data-repeater-create class="btn btn-info mt-repeater-add mt-3">
                                <i class="fa fa-plus"></i> Tambah Jabatan</a>
                        </div>

	        		<?= form_close(); ?>
            	</fieldset>

            	<fieldset id="field-single" style="display: none;">
            		<?= form_open('', ['id' => 'form-single']); ?>

            			<div class="form-group">
	                    	<?= form_label('Kode Jabatan', 'id_kode_jabatan'); ?>
	                    	<?= form_input('Jabatan[kode_jabatan]', '', [
	                    		'class' => 'form-control',
	                    		'id' => 'id_kode_jabatan',
	                    	]); ?>
            			</div>

            			<div class="form-group">
	                        <?= form_label('Nama Jabatan', 'id_nama_jabatan'); ?>
	                    	<?= form_input('Jabatan[nama_jabatan]', '', [
	                    		'class' => 'form-control',
	                    		'id' => 'id_nama_jabatan',
	                    	]); ?>
	                    </div>

	        		<?= form_close(); ?>
            	</fieldset>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn dark btn-outline" data-dismiss="modal">Tutup</button>
                <button type="button" id="btn-save" class="btn btn-success ladda-button" data-style="expand-right">
                	<span class="ladda-label">Simpan</span></button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
