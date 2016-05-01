//
//  ColorSchemes.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import UIKit

//Biome.None
//Biome.Ocean
//Biome.Beach
//Biome.Grassland
//Biome.Forest
//Biome.RainForest
//Biome.Jungle
//Biome.Savannah
//Biome.TemperateDesert
//Biome.Shrubland
//Biome.Scorched
//Biome.Taiga
//Biome.Tundra
//Biome.Snow

let ColorSchemes : [ColorScheme] = [
  [  // 0 -> Earth-Like
    Biome.Ocean: UIColor(rgba:            "#00B2ED"),
    Biome.Beach: UIColor(rgba:            "#D6BB96"),
    Biome.Grassland: UIColor(rgba:        "#B0FA93"),
    Biome.Forest: UIColor(rgba:           "#0AD11B"),
    Biome.RainForest: UIColor(rgba:       "#05A613"),
    Biome.Jungle: UIColor(rgba:           "#01730B"),
    Biome.Savannah: UIColor(rgba:         "#F4BC6F"),
    Biome.TemperateDesert: UIColor(rgba:  "#FFB34A"),
    Biome.Shrubland: UIColor(rgba:        "#739C68"),
    Biome.Scorched: UIColor(rgba:         "#FFBF00"),
    Biome.Taiga: UIColor(rgba:            "#00DE04"),
    Biome.Tundra: UIColor(rgba:           "#EBFFEB"),
    Biome.Snow: UIColor(rgba:             "#FFFFFF"),
  ],
  [  // 1 -> Primarily Green
    Biome.Ocean: UIColor(rgba:            "#01579B"),
    Biome.Beach: UIColor(rgba:            "#FFEB3B"),
    Biome.Grassland: UIColor(rgba:        "#8BC34A"),
    Biome.Forest: UIColor(rgba:           "#558B2F"),
    Biome.RainForest: UIColor(rgba:       "#33691E"),
    Biome.Jungle: UIColor(rgba:           "#1B5E20"),
    Biome.Savannah: UIColor(rgba:         "#81C784"),
    Biome.TemperateDesert: UIColor(rgba:  "#CDDC39"),
    Biome.Shrubland: UIColor(rgba:        "#4CAF50"),
    Biome.Scorched: UIColor(rgba:         "#FFC107"),
    Biome.Taiga: UIColor(rgba:            "#B2FF59"),
    Biome.Tundra: UIColor(rgba:           "#EBFFEB"),
    Biome.Snow: UIColor(rgba:             "#FFFFFF"),
  ],
  [  // 2 -> Primarily Frozen (@TODO)
    Biome.Ocean: UIColor(rgba:            "#00BFFF"),
    Biome.Beach: UIColor(rgba:            "#00BFFF"),
    Biome.Grassland: UIColor(rgba:        "#00BFFF"),
    Biome.Forest: UIColor(rgba:           "#00BFFF"),
    Biome.RainForest: UIColor(rgba:       "#00BFFF"),
    Biome.Jungle: UIColor(rgba:           "#00BFFF"),
    Biome.Savannah: UIColor(rgba:         "#00BFFF"),
    Biome.TemperateDesert: UIColor(rgba:  "#00BFFF"),
    Biome.Shrubland: UIColor(rgba:        "#00BFFF"),
    Biome.Scorched: UIColor(rgba:         "#00BFFF"),
    Biome.Taiga: UIColor(rgba:            "#00BFFF"),
    Biome.Tundra: UIColor(rgba:           "#00BFFF"),
    Biome.Snow: UIColor(rgba:             "#00BFFF"),
  ],
  [  // 3 -> Desert Planet
    Biome.Ocean: UIColor(rgba:            "#DD2C00"),
    Biome.Beach: UIColor(rgba:            "#FF6E40"),
    Biome.Grassland: UIColor(rgba:        "#FFE0B2"),
    Biome.Forest: UIColor(rgba:           "#558B2F"),
    Biome.RainForest: UIColor(rgba:       "#FFC107"),
    Biome.Jungle: UIColor(rgba:           "#FFA000"),
    Biome.Savannah: UIColor(rgba:         "#FF8F00"),
    Biome.TemperateDesert: UIColor(rgba:  "#FFC400"),
    Biome.Shrubland: UIColor(rgba:        "#EF6C00"),
    Biome.Scorched: UIColor(rgba:         "#E65100"),
    Biome.Taiga: UIColor(rgba:            "#00BFFF"),
    Biome.Tundra: UIColor(rgba:           "#E3F2FD"),
    Biome.Snow: UIColor(rgba:             "#E0F7FA"),
  ],
  [  // 4 -> Metal Planet (Dull Grayscale, perhaps with Purple)
    Biome.Ocean: UIColor(rgba:            "#004D40"),
    Biome.Beach: UIColor(rgba:            "#B388FF"),
    Biome.Grassland: UIColor(rgba:        "#6200EA"),
    Biome.Forest: UIColor(rgba:           "#3F51B5"),
    Biome.RainForest: UIColor(rgba:       "#263238"),
    Biome.Jungle: UIColor(rgba:           "#263238"),
    Biome.Savannah: UIColor(rgba:         "#263238"),
    Biome.TemperateDesert: UIColor(rgba:  "#795548"),
    Biome.Shrubland: UIColor(rgba:        "#F4511E"),
    Biome.Scorched: UIColor(rgba:         "#424242"),
    Biome.Taiga: UIColor(rgba:            "#BDBDBD"),
    Biome.Tundra: UIColor(rgba:           "#616161"),
    Biome.Snow: UIColor(rgba:             "#FAFAFA"),
  ],
  [  // 5 -> Rustic Green (Aincrad)
    Biome.Ocean: UIColor(rgba:            "#18FFFF"),
    Biome.Beach: UIColor(rgba:            "#FFEB3B"),
    Biome.Grassland: UIColor(rgba:        "#8BC34A"),
    Biome.Forest: UIColor(rgba:           "#558B2F"),
    Biome.RainForest: UIColor(rgba:       "#607D8B"),
    Biome.Jungle: UIColor(rgba:           "#1B5E20"),
    Biome.Savannah: UIColor(rgba:         "#81C784"),
    Biome.TemperateDesert: UIColor(rgba:  "#CDDC39"),
    Biome.Shrubland: UIColor(rgba:        "#4CAF50"),
    Biome.Scorched: UIColor(rgba:         "#FFC107"),
    Biome.Taiga: UIColor(rgba:            "#B2FF59"),
    Biome.Tundra: UIColor(rgba:           "#EBFFEB"),
    Biome.Snow: UIColor(rgba:             "#FFFFFF"),
  ],
  [  // 6 -> Psychedelic (Disboard)
    Biome.Ocean: UIColor(rgba:            "#00E5FF"),
    Biome.Beach: UIColor(rgba:            "#F8BBD0"),
    Biome.Grassland: UIColor(rgba:        "#E91E63"),
    Biome.Forest: UIColor(rgba:           "#E91E63"),
    Biome.RainForest: UIColor(rgba:       "#E040FB"),
    Biome.Jungle: UIColor(rgba:           "#D500F9"),
    Biome.Savannah: UIColor(rgba:         "#00E676"),
    Biome.TemperateDesert: UIColor(rgba:  "#00C853"),
    Biome.Shrubland: UIColor(rgba:        "#CDDC39"),
    Biome.Scorched: UIColor(rgba:         "#8E24AA"),
    Biome.Taiga: UIColor(rgba:            "#00BFFF"),
    Biome.Tundra: UIColor(rgba:           "#1565C0"),
    Biome.Snow: UIColor(rgba:             "#ECEFF1"),
  ],
  [  // 7 -> Dark Tones (Prometheus)
    Biome.Ocean: UIColor(rgba:            "#212121"),
    Biome.Beach: UIColor(rgba:            "#0097A7"),
    Biome.Grassland: UIColor(rgba:        "#1B5E20"),
    Biome.Forest: UIColor(rgba:           "#004D40"),
    Biome.RainForest: UIColor(rgba:       "#006064"),
    Biome.Jungle: UIColor(rgba:           "#33691E"),
    Biome.Savannah: UIColor(rgba:         "#BF360C"),
    Biome.TemperateDesert: UIColor(rgba:  "#BF360C"),
    Biome.Shrubland: UIColor(rgba:        "#BF360C"),
    Biome.Scorched: UIColor(rgba:         "#E0E0E0"),
    Biome.Taiga: UIColor(rgba:            "#E0E0E0"),
    Biome.Tundra: UIColor(rgba:           "#795548"),
    Biome.Snow: UIColor(rgba:             "#795548"),
  ],
]



























































