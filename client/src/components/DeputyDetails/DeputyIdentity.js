import React from 'react/addons';

class DeputyIdentity extends React.Component {

	render() {
		return (
			<div className="deputyIdentity">
				<div>{this.props.surname}</div>
				<div>{this.props.name}</div>
				<div>{this.props.party}</div>
			</div>
		);
	}
}

DeputyIdentity.propTypes = {
	id: React.PropTypes.number.isRequired,
	name: React.PropTypes.string.isRequired,
	surname: React.PropTypes.string.isRequired,
	slug: React.PropTypes.string.isRequired,
}

DeputyIdentity.defaultProps = {image: "dummy.png"}


export default DeputyIdentity;
