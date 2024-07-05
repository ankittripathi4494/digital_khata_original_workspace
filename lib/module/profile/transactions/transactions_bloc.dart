import 'package:dkapp/module/profile/transactions/transactions_event.dart';
import 'package:dkapp/module/profile/transactions/transactions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc() : super(TransactionsInitialState()) {
    on<AddCashInTransactionEvent>((event, emit) {
      // TODO: implement event handler
    });
    
  }
}
