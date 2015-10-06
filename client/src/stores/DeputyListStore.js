import AltInstance from '../lib/AltInstance';
import ImmutableStore from 'alt/utils/ImmutableUtil';
import { List } from 'immutable';
import ActionsDeputyList from 'actions/DeputyList';
//import ActionsDeputyDetails from 'actions/DeputyDetails';

class DeputyListStore {

	constructor() {
		let { updateDeputyList } = ActionsDeputyList;
		//let { showDeputyDetails } = ActionsDeputyDetails;

		this.bindListeners({
			updateDeputyList: updateDeputyList,
			//getDeputy: showDeputyDetails
		});

		this.state = List();
	}

	//getDeputy(deputyId) {
		//console.log("STORE: request to get deputy ID");
		//if(this.state.size !== 0){
			//console.log("Requesting deputy details " + deputyId)

			//console.log("Will search deputy");
			//let deputyIndex = this.state.findIndex((deputy) => deputy.id === deputyId);
			//console.log(deputyIndex + "found");
			//return deputyIndex !== (-1) ? this.state[deputyIndex] : false;
		//}
	//}

	updateDeputyList() {
		if (this.state.size === 0) {
			console.log("Requesting deputy list");
			// Service
			var request = new XMLHttpRequest();
			var that = this;
			request.open('GET', 'http://pole:8001/deputies', true);
			request.setRequestHeader('Content-Type', 'application/json; charset=UTF-8');
			request.onload = function() {
				if (request.status >= 200 && request.status < 400) {
					// Success!
					var data = JSON.parse(request.responseText);
					return that.setState(data);
				} else {
					// We reached our target server, but it returned an error
					console.log("Server not ready");
				}
			};

			request.onerror = function() {
				// There was a connection error of some sort
				console.log("An error happended during retrieval");
			};

			request.send();
		}

		return this.state;
	}
}

export default AltInstance.createStore(ImmutableStore(DeputyListStore));


// FLUX stopre
//import {EventEmitter} from 'events';
//import _ from 'lodash'; // Might not need, use object-assign instead ?
//import {DEPUTY_LIST_URL} from '../constants/Constants'

//let DeputyStore = _.extend({}, EventEmitter.prototype, {

//deputies: [
//{
//"id": 1,
//"name":  "Maréchale Lepen",
//"surname" : "Marion",
//"party" : "fn",
//"slug": "marion-marechale-lepen"
//},
//{
//"id": 2,
//"name":  "Aubry",
//"surname" : "Martine",
//"party" : "Parti socialiste",
//"slug": "martine-aubry"
//}
//],

//getState: function(){
//var request = new XMLHttpRequest();
//request.open('GET', DEPUTY_LIST_URL, true);

//request.onload = function() {
//if (request.status >= 200 && request.status < 400) {
//return JSON.parse(request.responseText);
//} else {
//// We reached our target server, but it returned an error
//}
//};

//request.onerror = function() {
//console.log("Error while calling webserver");
//return [];
//};

//request.send();
//return [];
//},
//});

//export default DeputyStore;
