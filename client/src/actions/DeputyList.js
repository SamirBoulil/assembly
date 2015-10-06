import Immutable   from 'immutable';
import AltInstance from '../lib/AltInstance';

class DeputyListActions {
	updateDeputyList() { this.dispatch(); }
	searchDeputyList(keywords){ this.dispatch(keywords) }
}

export default AltInstance.createActions(DeputyListActions);
