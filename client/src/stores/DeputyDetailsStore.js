import AltInstance from '../lib/AltInstance';
import ImmutableStore from 'alt/utils/ImmutableUtil';
import { List } from 'immutable';
import ActionsDeputyDetails from 'actions/DeputyDetails';
import DeputyListStore from './DeputyListStore';

class DeputyDetailsStore {

	constructor() {
		let { showDeputyDetails } = ActionsDeputyDetails;

		this.bindListeners({
			getDeputy: showDeputyDetails
		});

		this.state = {}
	}

	getDeputy(deputyId) {
		console.log("DeputyDetails: retrieve information of deputy id" + deputyId);

		if(this.state.size !== 0){
			console.log("Requesting deputy details " + deputyId)

			console.log("Will search deputy");
			let deputyIndex = DeputyListStore.state.findIndex((deputy) => deputy.id === deputyId);
			console.log(deputyIndex + "found");

			if(deputyIndex  !== -1) {
				let tmpState = {}
				tmpState["identity"] = DeputyListStore.state[deputyIndex]
				tmpState["votes"] = []

				// To module obviously
				var request = new XMLHttpRequest();
				var that = this;
				request.open('GET', 'http://pole:8001/deputies/'+tmpState['identity']['slug']+'/votes', true);
				request.setRequestHeader('Content-Type', 'application/json; charset=UTF-8');
				request.onload = function() {
					if (request.status >= 200 && request.status < 400) {
						// Success!
						var data = JSON.parse(request.responseText);
						tmpState = that.state;
						tmpState["votes"] = data[0]["votes"]
						return that.setState(tmpState);
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


				this.setState(tmpState)
				return deputyIndex !== (-1) ? tmpState : false;
			} else {
				return false;
			}
		}
	}
}


export default AltInstance.createStore(ImmutableStore(DeputyDetailsStore));
