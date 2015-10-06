import React from 'react/addons';
import ActionsDeputyList from 'actions/DeputyList';

class SearchCenter extends React.Component {

	constructor(props){
		super(props);
		this.setState({value: ""});
		this.state = {value: ""};

		this._onChange = this._onChange.bind(this)
	}

	_onChange(event){
		let value = event.target.value;
		this.setState({value: value});
		ActionsDeputyList.searchDeputyAction(value);
	}

	render(){
		let value = ""
		if(typeof(this.state.value) !== "undefined"){
			value = this.state.value;
		}
		return (<input type="text" onChange={this._onChange} value={value} />);
	}
}


export default SearchCenter;
