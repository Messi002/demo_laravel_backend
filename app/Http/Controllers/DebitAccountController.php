<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class DebitAccountController extends Controller
{
    protected $firestore;

    public function __construct()
    {
        $this->firestore = app('firestore');
    }


    public function index()
    {
        $accounts = $this->firestore->collection('debit_accounts')->documents();
        $accountList = [];

        foreach ($accounts as $account) {
            if ($account->exists()) {
                $accountList[] = $account->data(); 
            }
        }

        return response()->json($accountList); 
    }
}
