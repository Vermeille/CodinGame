#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;

/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/
int main()
{
    int N; // the number of points used to draw the surface of Mars.
    cin >> N; cin.ignore();
    for (int i = 0; i < N; i++) {
        int LAND_X; // X coordinate of a surface point. (0 to 6999)
        int LAND_Y; // Y coordinate of a surface point. By linking all the points together in a sequential fashion, you form the surface of Mars.
        cin >> LAND_X >> LAND_Y; cin.ignore();
    }

    int preverr = 0;
    int integralerr = 0;

    // game loop
    while (1) {
        int X;
        int Y;
        int HS; // the horizontal speed (in m/s), can be negative.
        int VS; // the vertical speed (in m/s), can be negative.
        int F; // the quantity of remaining fuel in liters.
        int R; // the rotation angle in degrees (-90 to 90).
        int P; // the thrust power (0 to 4).
        cin >> X >> Y >> HS >> VS >> F >> R >> P; cin.ignore();

        int err = 227 - Y;
        std::cerr << "err: " << err << std::endl;
        // A very badly calibrated PID
        int thrust = -0.005 * err - 0.05 * (err - preverr) + 0.000175 * integralerr;
        std::cerr << "thrust: " << thrust << std::endl;
        preverr = err;
        integralerr += err;

        // Write an action using cout. DON'T FORGET THE "<< endl"
        // To debug: cerr << "Debug messages..." << endl;

        cout << "0 " << (max(0, min(4, 4 - thrust))) << endl; // R P. R is the desired rotation angle. P is the desired thrust power.
    }
}
