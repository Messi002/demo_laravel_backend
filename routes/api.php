<?php

use App\Http\Controllers\TransferController;
use App\Http\Controllers\DebitAccountController;
use App\Http\Controllers\BeneficiaryController;
use Illuminate\Support\Facades\Route;




Route::get('/status', function () {
    return response()->json(['status' => 'API is working'], 200);
});


Route::post('/transfers', [TransferController::class, 'store']);
Route::get('/transfers', [TransferController::class, 'index']);

Route::get('/beneficiaries', [BeneficiaryController::class, 'index']);
Route::delete('/beneficiaries/{id}', [BeneficiaryController::class, 'destroy']);
Route::put('/beneficiaries/{id}', [BeneficiaryController::class, 'update']);

Route::get('/debit-accounts', [DebitAccountController::class, 'index']);


// /api/beneficiaries?pageSize=10
// /api/beneficiaries?pageSize=10&lastDocumentId=LAST_DOCUMENT_ID