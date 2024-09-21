<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Kreait\Firebase\Exception\FirebaseException;

class TransferController extends Controller
{
    protected $firestore;

    public function __construct()
    {
        $this->firestore = app('firestore');
    }

    
    public function store(Request $request)
    {
        $validated = $request->validate([
            'account_number' => 'required|string',
            'bank' => 'required|string',
            'beneficiary_name' => 'required|string',
            'beneficiary_account_number' => 'required|string',
            'amount' => 'required|numeric',
            'description' => 'required|string',
            'is_anonymous' => 'boolean',
            'transaction_date' => 'required|date',
        ]);

        try {
            $transferRef = $this->firestore->collection('transfers')->newDocument();
            $transferRef->set($validated);

            $responseData = $validated;
            $responseData['id'] = $transferRef->id();

            return response()->json([
                'isSuccess' => true,
                'statusCode' => 201,
                'message' => 'Transfer created successfully.',
                'responseJson' => $responseData,
            ], 201);

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

   
    public function index()
    {
        try {
            $transfers = $this->firestore->collection('transfers')->documents();

            $transferList = [];

            foreach ($transfers as $transfer) {
                if ($transfer->exists()) {
                    $transferData = $transfer->data();
                    $transferData['id'] = $transfer->id();
                    $transferList[] = $transferData;
                }
            }

            // Successful response
            return response()->json([
                'isSuccess' => true,
                'statusCode' => 200,
                'message' => 'Transfers fetched successfully.',
                'responseJson' => [
                    'transfers' => $transferList,
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
