<?php

namespace App\Http\Controllers;

use Kreait\Firebase\Factory;
use Illuminate\Http\Request;

class BeneficiaryController extends Controller
{
    protected $firestore;

    public function __construct()
    {
        $this->firestore = app('firestore');
    }

    public function index(Request $request)
    {
        $pageSize = $request->input('pageSize', 10);
        $lastDocumentId = $request->input('lastDocumentId');

        $collection = $this->firestore->collection('beneficiaries');

        if ($lastDocumentId) {
            $lastDocument = $collection->document($lastDocumentId)->snapshot();
            $query = $collection->orderBy('name')->startAfter($lastDocument)->limit($pageSize);
        } else {
            $query = $collection->orderBy('name')->limit($pageSize);
        }

        $beneficiaries = $query->documents();
        $beneficiaryList = [];

        foreach ($beneficiaries as $beneficiary) {
            if ($beneficiary->exists()) {
                $beneficiaryData = $beneficiary->data();
                $beneficiaryData['id'] = $beneficiary->id();
                $beneficiaryList[] = $beneficiaryData;
            }
        }

        $rows = $beneficiaries->rows();
        $lastDocument = end($rows);
        $nextDocumentId = $lastDocument ? $lastDocument->id() : null;

        // Successful response
        return response()->json([
            'isSuccess' => true,
            'statusCode' => 200,
            'message' => 'Beneficiary list fetched successfully.',
            'responseJson' => [
                'beneficiaries' => $beneficiaryList,
                'nextDocumentId' => $nextDocumentId
            ],
        ], 200);
    }

    public function update(Request $request, $id)
    {
        $validated = $request->validate([
            'name' => 'required|string',
            'bank' => 'required|string',
            'account_number' => 'required|string',
        ]);

        $docRef = $this->firestore->collection('beneficiaries')->document($id);
        $docSnapshot = $docRef->snapshot();

        if (!$docSnapshot->exists()) {
            // Error response
            return response()->json([
                'isSuccess' => false,
                'statusCode' => 404,
                'message' => 'Beneficiary not found.',
                'responseJson' => new \stdClass() 
            ], 404);
        }

        $docRef->set($validated, ['merge' => true]);

        // Successful response
        return response()->json([
            'isSuccess' => true,
            'statusCode' => 200,
            'message' => 'Beneficiary updated successfully.',
            'responseJson' => new \stdClass() 
        ], 200);
    }

    public function destroy($id)
    {
        $docRef = $this->firestore->collection('beneficiaries')->document($id);
        $docSnapshot = $docRef->snapshot();

        if (!$docSnapshot->exists()) {
            // Error response
            return response()->json([
                'isSuccess' => false,
                'statusCode' => 404,
                'message' => 'Beneficiary not found.',
                'responseJson' => new \stdClass() 
            ], 404);
        }

        $docRef->delete();

        // Successful response
        return response()->json([
            'isSuccess' => true,
            'statusCode' => 204,
            'message' => 'Beneficiary deleted successfully.',
            'responseJson' => [
                'deleted' => [],
            ]
        ], 204);
    }
}
