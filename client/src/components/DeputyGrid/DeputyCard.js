import React from 'react/addons';


/*
 * Component displaying a deputy information as a card.
 */
class DeputyCard extends React.Component {
	render() {
		return (
			<div className="deputyCard">
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
