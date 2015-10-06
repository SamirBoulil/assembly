import React from 'react/addons';
import DeputyCard from './DeputyCard';
import DeputyListStore from '../../stores/DeputyListStore';
import DeputyListActions from 'actions/DeputyList';


class DeputyGrid extends React.Component {

	constructor(props) {
		super(props);
		this.state = { deputies: DeputyListStore.getState() };

		this.listChanged = this.listChanged.bind(this)
		DeputyListActions.updateDeputyList()
	}

	componentDidMount()    {
		DeputyListStore.listen(this.listChanged); 
	}
	componentWillUnmount(){ DeputyListStore.unlisten(this.listChanged); }

	listChanged(deputyList)  { this.setState({ deputies: deputyList }); }

	render(){
		return (
			<div className="deputyGrid">
			{
				this.state.deputies.map((elem) => {
					return (<DeputyCard {...elem} />);
				})
			}
			</div>
		);
	};
}
DeputyGrid.propType = {deputies: React.PropTypes.element.isRequired}
DeputyGrid.defaultProps = {deputies: []}


export default DeputyGrid;
