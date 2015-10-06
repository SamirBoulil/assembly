import AltInstance from '../lib/AltInstance';

class Api {

	static downloadDeputyList(cb){
		console.log("Requesting deputy list");
		var request = new XMLHttpRequest();
		var that = this;
		request.open('GET', 'http://pole:8001/deputies', true);
		request.setRequestHeader('Content-Type', 'application/json; charset=UTF-8');
		request.onload = function() {
			if (request.status >= 200 && request.status < 400) {
				var data = JSON.parse(request.responseText);
				cb(data)
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

	static searchDeputy(name, cb) {
		console.log("Searching deputy: "+ name);
		var request = new XMLHttpRequest();
		var that = this;
		request.open('GET', 'http://pole:8001/deputies?search='+name, true);
		request.setRequestHeader('Content-Type', 'application/json; charset=UTF-8');
		request.onload = function() {
			if (request.status >= 200 && request.status < 400) {
				var data = JSON.parse(request.responseText);
				cb(data)
			} else {
				// We reached our target server, but it returned an error
				console.log("Server not ready");
			}
		};
		request.onerror = function() {
			// There was a connection error of some sort
			console.log("An error happended during retrieval");
		};

		request.send()
	}
}

export default Api;
