import 'package:bloc/bloc.dart';

enum ShopEvent
{
    increment, decrement
}

final ShopBloc shopBloc = ShopBloc();

class ShopBloc extends Bloc<ShopEvent, int>
{

    @override
    int get initialState
    => 0;

    @override
    Stream<int> mapEventToState(int currentState, ShopEvent event)
    async* {
        switch (event)
        {
            case ShopEvent.decrement:
                yield currentState - 1;
                print(currentState);

                break;
            case ShopEvent.increment:
                yield currentState + 1;
                print(currentState);
                break;
        }
    }

    static getShopBloc()
    {
        return shopBloc;
    }

}