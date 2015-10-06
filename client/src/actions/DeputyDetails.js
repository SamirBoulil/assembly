import Immutable   from 'immutable';
import AltInstance from '../lib/AltInstance';

class DeputyDetailsActions {
	showDeputyDetails(deputyId) { this.dispatch(deputyId); }
	hideDeputyDetails() { this.dispatch(); }
}

export default AltInstance.createActions(DeputyDetailsActions);
