i#include <iostream>
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
    std::vector<std::pair<long, long>> houses;
    int N;
    cin >> N; cin.ignore();
    for (int i = 0; i < N; i++) {
        int X;
        int Y;
        cin >> X >> Y; cin.ignore();
        std::cerr << X << " " << Y << std::endl;
        houses.push_back(std::make_pair(X, Y));
    }

    auto x_cmp = [](const std::pair<long, long>& a, const std::pair<long, long>& b) {
            return a.first < b.first;
        };
    auto y_cmp = [](const std::pair<long, long>& a, const std::pair<long, long>& b) {
            return a.second < b.second;
        };
    auto minmax = std::minmax_element(houses.begin(), houses.end(), x_cmp);

    long horizontal = minmax.second->first - minmax.first->first;

    std::cerr << "hor: " << horizontal << endl;

    long pos;
    std::nth_element(houses.begin(), houses.begin() + houses.size() / 2, houses.end(), y_cmp);
    pos = houses[houses.size() / 2].second;
    std::cerr << "pos: " << pos << endl;

    long len = horizontal;
    for (auto& h : houses)
        len += std::abs(h.second - pos);
    // Write an action using cout. DON'T FORGET THE "<< endl"
    // To debug: cerr << "Debug messages..." << endl;

    cout << len << endl;
}
