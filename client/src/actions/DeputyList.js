import Immutable   from 'immutable';
import AltInstance from '../lib/AltInstance';

class DeputyListActions {
	loadDeputyListAction() { this.dispatch(); }
	searchDeputyAction(keywords) { this.dispatch(keywords); }
}

export default AltInstance.createActions(DeputyListActions);
