<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class StockNewTrigger extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        // DB::unprepared(
        // 'CREATE TRIGGER stock_account AFTER INSERT ON gas
        //       FOR EACH ROW
        //         BEGIN
        //           INSERT INTO stocks(stock, item, type, created_at, updated_at) VALUES (0, NEW.id, 2, NEW.created_at, NEW.updated_at);
        //       END
        // '
      // );
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        // DB::unprepared('DROP TRIGGER stock_account');
    }
}
