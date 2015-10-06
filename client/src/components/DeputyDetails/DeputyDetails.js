import React from 'react/addons';
import DeputyDetailsStore from '../../stores/DeputyDetailsStore';
import DeputyDetailsActions from 'actions/DeputyDetails';

import DeputyIdentity from './DeputyIdentity'
import DeputyVotes from './DeputyVotes'

/*
 * Component displaying a deputy information as a card.
 */
class DeputyDetails extends React.Component {

	constructor(props){
		super(props)
		this.state = { deputy: DeputyDetailsStore.getState() };

		this.showDeputy = this.showDeputy.bind(this);
	}

	componentDidMount(){
		DeputyDetailsStore.listen(this.showDeputy);
	}
	componentWillUnmount(){
		DeputyDetailsStore.unlisten(this.showDeputy);
	}

	showDeputy(deputyDetails){
		this.setState({deputy: deputyDetails});
	}

	render() {
		if(Object.keys(this.state.deputy).length > 0){
			return (
				<div className="deputyDetails">
					<DeputyIdentity {...this.state.deputy.identity} />
					<DeputyVotes {...this.state.deputy.votes} />
				</div>
			);
		} else {
			return (<div></div>);
		}

	}
}

export default DeputyDetails;
