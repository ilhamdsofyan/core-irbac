<h1 class="page-title"><?= $title ?></h1>

<div class="row">
    <div class="col-md-12">
        <div class="portlet light bordered">
            <div class="portlet-body">
            	<div class="table-toolbar">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="btn-group">
                                <button id="btn-add" class="btn sbold btn-primary"> Tambah
                                    <i class="fa fa-plus"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

            	<table class="table table-striped table-bordered table-hover dt-responsive" width="100%" id="table-dokumen">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Tanggal</th>
                            <th>Deskripsi</th>
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
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">Modal Title</h4>
            </div>
            <div class="modal-body">
            	<fieldset id="field-single">
            		<?= form_open('', ['id' => 'form-single']); ?>

                        <div class="row form-group">
                            <div class="col-md-12">
    	                    	<?= form_label('Tanggal', 'id_date'); ?>
    	                    	<?= form_input('Calendar[date]', '', [
    	                    		'class' => 'form-control',
    	                    		'id' => 'id_date',
                                    'readonly' => true,
    	                    	]); ?>
                            </div>
                        </div>

                        <div class="row form-group">
                            <div class="col-md-12">
    	                        <?= form_label('Deskripsi', 'id_event'); ?>
    	                    	<?= form_textarea('Calendar[event]', '', [
    	                    		'class' => 'form-control',
    	                    		'id' => 'id_event',
                                    'style' => 'height:100px;resize:none'
    	                    	]); ?>
                            </div>
                        </div>

	        		<?= form_close(); ?>
            	</fieldset>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn dark btn-outline" data-dismiss="modal">Tutup</button>
                <button type="button" id="btn-save" class="btn green ladda-button" data-style="expand-right">
                	<span class="ladda-label">Simpan</span></button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
