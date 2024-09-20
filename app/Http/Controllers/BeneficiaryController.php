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
                $beneficiaryList[] = $beneficiary->data();
            }
        }
    
        $rows = $beneficiaries->rows();
        $lastDocument = end($rows);  
        $nextDocumentId = $lastDocument ? $lastDocument->id() : null;
    
        return response()->json([
            'beneficiaries' => $beneficiaryList,
            'nextDocumentId' => $nextDocumentId, 
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
            return response()->json(['error' => 'Beneficiary not found.'], 404);
        }

        $docRef->set($validated, ['merge' => true]);

        return response()->json(['message' => 'Beneficiary updated successfully.']);
    }

    public function destroy($id)
    {
        $this->firestore->collection('beneficiaries')->document($id)->delete();

        return response()->json(['message' => 'Beneficiary deleted successfully.'],204);
    }
}


