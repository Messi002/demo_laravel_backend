<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Transfer extends Model
{
    protected $fillable = [
        'account_number',
        'bank',
        'beneficiary_name',
        'beneficiary_account_number',
        'amount',
        'description',
        'is_anonymous',
        'transaction_date', 


    ];
}
