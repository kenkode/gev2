<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class PurchaseOrder extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */

    public $subject;
    public $body;
    public $name;
    public $file;

    public function __construct($subject,$body,$name,$file)
    {
        //
        $this->subject = $subject;
        $this->body = $body;
        $this->name = $name;
        $this->file = $file;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->from('info@lixnet.net', 'Gas Express')
                    ->subject($this->subject)
                    ->view('emails.purchaseOrder')
                    ->attach($this->file);
    }
}
