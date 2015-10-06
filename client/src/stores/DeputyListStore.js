import AltInstance from '../lib/AltInstance';
import localStore from '../lib/LocalStorageInstance';;
import ImmutableStore from 'alt/utils/ImmutableUtil';
import { List } from 'immutable';
import ActionsDeputyList from 'actions/DeputyList';
import Api from '../services/Api';

//import ActionsDeputyDetails from 'actions/DeputyDetails';

class DeputyListStore {

	constructor() {
		let { loadDeputyListAction } = ActionsDeputyList;
		let { searchDeputyAction } = ActionsDeputyList;

		this.bindListeners({
			loadDeputyList: loadDeputyListAction,
			searchDeputy: searchDeputyAction
		});

		this.state = List();
	}

	loadDeputyList() {
		let that = this;

		//if (localStore.enabled === true && localStore.get('deputies') === ""){
		//// Downloading deputies
		//Api.downloadDeputyList((data) => {
		//return that.setState(data);
		//});

		//} else
		if (this.state.size === 0) {
			//let data = localStore.get('deputies');
			Api.downloadDeputyList((data) => {
				return that.setState(data);
			});
		} else {
			return this.state;
		}

		return false;
	}

	searchDeputy(keywords){
		let that = this;
		Api.searchDeputy(keywords, (data) => {
			that.setState(data);
		});
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
