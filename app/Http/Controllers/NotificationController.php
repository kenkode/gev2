<?php
namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Models\Notification;
use App\Http\Models\Audit;
use Redirect;
use Entrust;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;

class NotificationController extends Controller {

	/**
	 * Display a listing of audits
	 *
	 * @return Response
	 */
	public function index()
	{
		$header='Notification';
		$description='My Notifications';
		$notifications = Notification::where("user_id",Auth::user()->id)->orderBy('id','DESC')->get();

		Audit::logaudit('Notification', 'viewed notifications', 'viewed notifications in the system');

		return view('notifications.index', compact('notifications','header','description'));
	}

	/**
	 * Show the form for creating a new audit
	 *
	 * @return Response
	 */

    public function markasread($id)
	{
		$notification = Notification::findOrFail($id);
		$notification->is_read = 1;
		$notification->update();

		return Redirect::to('notifications/index')->withFlashMessage('Notification successfully marked as read!');
	}

	public function markallasread()
	{
		$notifications = Notification::where('user_id',Auth::user()->id)->get();
		foreach ($notifications as $notification) {
		$notification->is_read = 1;
		$notification->update();
        }
		return Redirect::to('notifications/index')->withFlashMessage('All Notifications successfully marked as read!');
	}

	public function create()
	{
		return View::make('audits.create');
	}

	/**
	 * Store a newly created audit in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
		$validator = Validator::make($data = Input::all(), Audit::$rules);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		Audit::create($data);

		return Redirect::route('audits.index');
	}

	/**
	 * Display the specified audit.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		$audit = Audit::findOrFail($id);

		return View::make('audits.show', compact('audit'));
	}

	/**
	 * Show the form for editing the specified audit.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function edit($id)
	{
		$audit = Audit::find($id);

		return View::make('audits.edit', compact('audit'));
	}

	/**
	 * Update the specified audit in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($id)
	{
		$audit = Audit::findOrFail($id);

		$validator = Validator::make($data = Input::all(), Audit::$rules);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		$audit->update($data);

		return Redirect::route('audits.index');
	}

	/**
	 * Remove the specified audit from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{
		Audit::destroy($id);

		return Redirect::route('audits.index');
	}

}
