import React from 'react/addons';

class DeputyVotes extends React.Component {

	render() {

		if (Object.keys(this.props).length > 0){
			var that = this;
		return (
			<div className="deputyVotes">
				List of votes:
				{
					Object.keys(this.props).map((i) => {
						let vote = that.props[i];
						return(
							<div>
								<div>({vote.decree.date}) {vote.decree.number} - {vote.decree.title}</div>
								<div>{ vote.vote_value }</div>
							</div>
						);
					})
				}
			</div>
		);
		} else {
			return (<div>No Votes for deputyes</div>);
		}
	}
}

export default DeputyVotes;
