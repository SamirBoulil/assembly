require('normalize.css');
require('styles/App.css');

import React from 'react/addons';
import SearchCenter from './SearchCenter';
import DeputyGrid from './DeputyGrid';
import DeputyDetails from './DeputyDetails';

//import AppDispatcher from '../dispatcher/AppDispatcher';

let yeomanImage = require('../images/yeoman.png');


class AppComponent extends React.Component {

	render() {
		return (
			<div className="index">
				<DeputyDetails />
				<SearchCenter />
				<DeputyGrid />
			</div>
		);
	}
}

AppComponent.defaultProps = {
};

export default AppComponent;
