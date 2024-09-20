<?php

namespace App\Models;

class DebitAccount
{
    public $bank_name;
    public $account_number;

    public function __construct($bank_name, $account_number)
    {
        $this->bank_name = $bank_name;
        $this->account_number = $account_number;
    }
}
