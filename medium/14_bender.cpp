#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <utility>
#include <set>

using namespace std;

typedef std::vector<std::string> Map;

std::pair<int, int> Find(const Map& m, char element) {
    for (int i = 0; i < m.size(); ++i) {
        for (int j = 0; j < m[i].size(); ++j) {
            if (m[i][j] == element) {
                return std::make_pair(i, j);
            }
        }
    }
    return std::make_pair(-1, -1);
}

enum Direction { South, East, North, West };

char At(const Map& m, const std::pair<int, int>& p) {
    return m[p.first][p.second];
}

char& At(Map& m, const std::pair<int, int>& p) {
    return m[p.first][p.second];
}
struct Bender {
    Map map_;
    Direction dir_;
    bool forward_;
    bool breaker_;
    std::pair<int, int> pos_;
    std::pair<int, int> tp1_;
    std::pair<int, int> tp2_;

    Bender(const Map& map)
        : map_(map), dir_(South), pos_(Find(map, '@')), forward_(true), breaker_(false),
        tp1_(-1, -1), tp2_(-1, -1) {
        for (int i = 0; i < map.size(); ++i) {
            for (int j = 0; j < map[i].size(); ++j) {
                if (map[i][j] == 'T') {
                    if (tp1_.first == -1) {
                        tp1_ = std::make_pair(i, j);
                    } else {
                        tp2_ = std::make_pair(i, j);
                        break;
                    }
                }
            }
        }
    }

    bool operator<(const Bender& b) const {
        if (map_ != b.map_)
            return map_ < b.map_;
        if (dir_ != b.dir_)
            return dir_ < b.dir_;
        if (forward_ != b.forward_)
            return forward_ < b.forward_;
        if (breaker_ != b.breaker_)
            return breaker_ < b.breaker_;
        if (pos_ != b.pos_)
            return pos_ < b.pos_;
        return false;
    }

    bool operator==(const Bender& b) const {
        return map_ == b.map_ && dir_ == b.dir_ && forward_ == b.forward_
            && breaker_ == b.breaker_ && pos_ == b.pos_;
    }

    std::pair<int, int> NextCell() {
        std::pair<int, int> pos = pos_;
        switch (dir_) {
            case South: pos.first += 1; break;
            case East: pos.second += 1; break;
            case North: pos.first -= 1; break;
            case West: pos.second -= 1; break;
        }
        return pos;
    }

    void Move() { pos_ = NextCell(); }

    void NextDir() {
        if (forward_) {
            dir_ = static_cast<Direction>((dir_ + 1) % 4);
        } else {
            dir_ = static_cast<Direction>((dir_ + 4 - 1) % 4);
        }
    }

    bool Walkable(char c) {
        return c == ' ' || c == '$' || (c == 'X' && breaker_) || c == 'S'
        || c == 'N' || c == 'W' || c == 'E' || c == 'B' || c == '@' || c == 'I'
        || c == 'T';
    }

    void Update() {
        auto pos = NextCell();
        if (!Walkable(At(map_, pos))) {
            dir_ = forward_ ? South : West;
            pos = NextCell();
            while (!Walkable(At(map_, pos))) {
                NextDir();
                pos = NextCell();
            }
        }
        Move();
    }

    void PostUpdate() {
        char cell = At(map_, pos_);
        switch (cell) {
            case 'S': dir_ = South; break;
            case 'W': dir_ = West; break;
            case 'E': dir_ = East; break;
            case 'N': dir_ = North; break;
            case 'B': breaker_ = !breaker_; break;
            case 'I': forward_ = ! forward_; break;
            case 'T': pos_ = (pos_ == tp1_) ? tp2_ : tp1_; break;
            case 'X': if (breaker_) { At(map_, pos_) = ' '; } break;
        }
    }

    bool IsDead() const { return At(map_, pos_) == '$'; }
    std::string WhereAmI() const {
        switch (dir_) {
            case South: return "SOUTH";
            case North: return "NORTH";
            case West: return "WEST";
            case East: return "EAST";
        }
    }
};

int main()
{
    Map map;
    std::set<Bender> visited;
    int L;
    int C;
    cin >> L >> C; cin.ignore();
    for (int i = 0; i < L; i++) {
        string row;
        getline(cin, row);
        map.push_back(row);
        cerr << row << endl;
    }
    Bender b(map);
    std::vector<std::string> dirs;

    while (!b.IsDead()) {
        b.Update();
        dirs.push_back(b.WhereAmI());
        auto was_here = visited.insert(b);
        if (!was_here.second) {
            std::cout << "LOOP\n";
            return 0;
        }
        b.PostUpdate();
    }

    for (auto& d : dirs) {
        std::cout << d << std::endl;
    }
}
