// Soup Kitchen
// Bryan DeGrendel (c) 2014

#include <SFML/Graphics.hpp>

int main(int argc, char *argv[])
{

  sf::RenderWindow window(sf::VideoMode(200, 200), "Soup Kitchen");

  sf::Event event;
  while (window.isOpen())
  {
    while (window.pollEvent(event))
    {
      if (event.type == sf::Event::Closed)
        window.close();
    }

    window.clear();
    window.display();
  }
  return 0;
}

