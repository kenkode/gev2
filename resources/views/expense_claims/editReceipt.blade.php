<?php 
	function asMoney($value){
		return number_format($value, 2);
	}
?>

@extends('accounting')
@section('content')

{{$receipts}}
{{$items}}

@stop