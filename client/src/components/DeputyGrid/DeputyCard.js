import React from 'react/addons';
import DeputyDetailsActions from 'actions/DeputyDetails';

/*
 * Component displaying a deputy information as a card.
 */
class DeputyCard extends React.Component {
	constructor(props){
		super(props);

		this.showDeputyDetails = this.showDeputyDetails.bind(this);
	}

	showDeputyDetails(){
		console.log("Show deputy Details " + this.props.name)
		DeputyDetailsActions.showDeputyDetails(this.props.id)
	}

	render() {
		return (
			<div className="deputyCard" onClick={this.showDeputyDetails}>
				<div className="image">{this.props.image}</div>
				<div className="name">{this.props.surname} {this.props.name}</div>
				<div className="party">{this.props.party}</div>
			</div>
		);
	}
}

DeputyCard.propTypes = {
	id: React.PropTypes.number.isRequired,
	name: React.PropTypes.string.isRequired,
	surname: React.PropTypes.string.isRequired,
	slug: React.PropTypes.string.isRequired,
}

DeputyCard.defaultProps = {image: "dummy.png"}

export default DeputyCard;
