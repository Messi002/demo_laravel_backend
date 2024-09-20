<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Transfer;
use Kreait\Firebase\Factory;
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

        $transferRef = $this->firestore->collection('transfers')->newDocument();
        $transferRef->set($validated);

        return response()->json(['message' => 'Transfer created successfully.'], 201);
    }


    public function index()
    {
        try {
            $transfers = $this->firestore->collection('transfers')->documents();

            $transferData = [];
            foreach ($transfers as $transfer) {
                if ($transfer->exists()) {
                    $transferData[] = $transfer->data();
                }
            }

            return response()->json($transferData, 200);
        } catch (FirebaseException $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
    
}
