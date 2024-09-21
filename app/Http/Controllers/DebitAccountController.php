<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Kreait\Firebase\Exception\FirebaseException;

class DebitAccountController extends Controller
{
    protected $firestore;

    public function __construct()
    {
        $this->firestore = app('firestore');
    }

    public function index()
    {
        try {
            $accounts = $this->firestore->collection('debit_accounts')->documents();
            $accountList = [];

            foreach ($accounts as $account) {
                if ($account->exists()) {
                    $accountData = $account->data();
                    $accountData['id'] = $account->id();
                    $accountList[] = $accountData;
                }
            }

            // Successful response
            return response()->json([
                'isSuccess' => true,
                'statusCode' => 200,
                'message' => 'Debit accounts fetched successfully.',
                'responseJson' => [
                    'debitAccounts' => $accountList,
                ],
            ], 200);

        } catch (FirebaseException $e) {
            // Error response
            return response()->json([
                'isSuccess' => false,
                'statusCode' => 500,
                'message' => $e->getMessage(),
                'responseJson' => new \stdClass() 
            ], 500);
        }
    }
}
