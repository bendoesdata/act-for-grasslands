<template>
  <div id="ref-accordion" class="accordion">
    <div class="accordion-header" @click="toggleAccordion">
      <div
        class="accordion-icon"
        :class="{ open: isOpen }"
        :style="{ transform: rotateTransform }"
      >
        <span class="plus">+</span>
      </div>
      <div class="accordion-title">View all references and credits</div>
    </div>
    <transition name="accordion-transition">
      <div class="accordion-content" v-show="isOpen">
        <div class="flex-container">
          <div
            class="accordion-text flex-text"
            :class="{ 'fade-in': isOpen, 'fade-out': !isOpen }"
          >
          <h2>National view and regional collapse</h2>
        <div>
          <p>
          USDA Agricultural Research Service. Rangeland Analysis Platform. In: Rangeland Analysis Platform [Internet]. 2023 [cited 11 Dec 2023]. Available: https://rangelands.app/</p>
          <p style="font-style: italic"> Data exclude areas of cropland, development, and water. Data use the historical satellite record to track vegetation loss in grasslands and rangelands and may not be suitable in forested areas.
          </p>
          <p>
            World Wildlife Fund. 2023 Plowprint Report. In: World Wildlife Fund [Internet]. 25 Oct 2023 [cited 11 Dec 2023]. Available: https://www.worldwildlife.org/publications/2023-plowprint-report 
          </p>
          <br>
        </div>
            <h2>Species</h2>
            <b>Northern Bobwhite</b>
            <p>
              Brennan LA, Hernández F, Williford D. Conservation and management.
              In: Northern Bobwhite (Colinus virginianus) [Internet]. 4 Mar 2020
              [cited 30 Aug 2023]. Available:
              https://birdsoftheworld.org/bow/species/norbob/cur/conservation
            </p>

            <p>
              U.S. Geological Survey. BBS trends 1966-2019. In: Eastern
              Ecological Science Center - Bird Population Studies [Internet].
              2019 [cited 29 Aug 2023]. Available:
              https://www.mbr-pwrc.usgs.gov/
            </p>
            <p>
              eBird Status and Trends. Data version: 2021. Fink, D., T. Auer, A. Johnston, M. Strimas-Mackey, S. Ligocki, O. Robinson, W. Hochachka, L. Jaromczyk, A. Rodewald, C. Wood, I. Davies, A. Spencer. 2022. eBird Status and Trends, Data Version: 2021; Released: 2022. Cornell Lab of Ornithology, Ithaca, New York. https://doi.org/10.2173/ebirdst.2021
            </p>
            <p class="photo-cred">Photo by Chad Hutchinson/Macaulay Library</p>
            <b>Pronghorn</b>
            <p>
              Kauffman MJ, Copeland HE, Berg J, Bergen S, Cole E, Cuzzocreo M,
              et al. Ungulate migrations of the western United States, Volume 1:
              U.S. Geological Survey Scientific Investigations Report 2020–5101.
              U.S. Department of the Interior, U.S. Geological Survey; 2020.
              doi:10.3133/sir20205101
            </p>
            <p class="photo-cred">Photo by Wenfei Tong</p>

            <b>Monarch Butterfly</b>
            <p>
              Semmens BX, Semmens DJ, Thogmartin WE, Wiederholt R, López-Hoffman
              L, Diffendorfer JE, et al. Quasi-extinction risk and population
              targets for the Eastern, migratory population of monarch
              butterflies (Danaus plexippus). Sci Rep. 2016;6: 23265.
            </p>

            <p>
              Schultz CB, Brown LM, Pelton E, Crone EE. Citizen science
              monitoring demonstrates dramatic declines of monarch butterflies
              in western North America. Biol Conserv. 2017;214: 343–346.
            </p>
            <p>Xerces Society for Invertebrate Conservation https://www.xerces.org/monarchs</p>
            <p class="photo-cred">Photo by Rod M.</p>

            <b>Greater Prairie-Chicken</b>
            <p>
              Johnson JA, Schroeder MA, Robb LA. Behavior. In: Greater
              Prairie-Chicken (Tympanuchus cupido) [Internet]. 4 Mar 2020 [cited
              30 Aug 2023]. Available:
              https://birdsoftheworld.org/bow/species/grpchi/cur/behavior
            </p>

            <p>
              Lautenbach JM, Plumb RT, Robinson SG, Hagen CA, Haukos DA, Pitman
              JC. Lesser Prairie-Chicken avoidance of trees in a grassland
              landscape. Rangeland Ecol Manage. 2017;70: 78–86.
            </p>
            <p class="photo-cred">Photo by Jonathan Fiely</p>

            <b>Rio Grande Cutthroat Trout</b>
            <p>
              Trout Unlimited. State of the trout: a report on the status and
              trends of native trout in the United States. Arlington, VA; 2015.
            </p>

            <p>
              Western Native Trout Initiative. Rio Grande Cutthroat Trout
              (Oncorhynchus clarkii virginalis). 2016 May.
            </p>
            <p class="photo-cred">Photo by Patrick Clayton Engbretson</p>

            <b>Northern Pintail</b>
            <p>
              Clark RG, Fleskes JP, Guyn KL, Haukos DA, Austin JE, Miller MR.
              Conservation and management. In: Northern Pintail (Anas acuta)
              [Internet]. 4 Mar 2020 [cited 29 Aug 2023]. Available:
              https://birdsoftheworld.org/bow/species/norpin/cur/conservation
            </p>

            <p>
              U.S. Fish and Wildlife Service. Waterfowl population status, 2022.
              Washington, D.C. USA: U.S. Department of the Interior; 2022.
              Available:
              https://www.fws.gov/media/waterfowl-population-status-2022
            </p>
            <p>
              eBird Status and Trends. Data version: 2021. Fink, D., T. Auer, A. Johnston, M. Strimas-Mackey, S. Ligocki, O. Robinson, W. Hochachka, L. Jaromczyk, A. Rodewald, C. Wood, I. Davies, A. Spencer. 2022. eBird Status and Trends, Data Version: 2021; Released: 2022. Cornell Lab of Ornithology, Ithaca, New York. https://doi.org/10.2173/ebirdst.2021
            </p>
            <p class="photo-cred">Photo by Matt Misewicz/Macaulay Library</p>

            <b>Ring-necked Pheasant</b>
            <p>
              U.S. Geological Survey. BBS trends 1966-2019. In: Eastern
              Ecological Science Center - Bird Population Studies [Internet].
              2019 [cited 29 Aug 2023]. Available:
              https://www.mbr-pwrc.usgs.gov/
            </p>

            <p>
              Whitmore RW, Pruess KP, Gold RE. Insect food selection by
              2-week-old Ring-Necked Pheasant chicks. J Wildl Manage. 1986;50:
              223–228.
            </p>
            <p>
              eBird Status and Trends. Data version: 2021. Fink, D., T. Auer, A. Johnston, M. Strimas-Mackey, S. Ligocki, O. Robinson, W. Hochachka, L. Jaromczyk, A. Rodewald, C. Wood, I. Davies, A. Spencer. 2022. eBird Status and Trends, Data Version: 2021; Released: 2022. Cornell Lab of Ornithology, Ithaca, New York. https://doi.org/10.2173/ebirdst.2021
            </p>
            <p class="photo-cred">Photo by Rachel Bush</p>

            <b>Elk</b>
            <p>
              Kauffman MJ, Copeland HE, Berg J, Bergen S, Cole E, Cuzzocreo M,
              et al. Ungulate migrations of the western United States, Volume 1:
              U.S. Geological Survey Scientific Investigations Report 2020–5101.
              U.S. Department of the Interior, U.S. Geological Survey; 2020.
              doi:10.3133/sir20205101
            </p>
            <p class="photo-cred">Photo by Wenfei Tong</p>

            <b>Bobolink</b>
            <p>
              U.S. Geological Survey. BBS trends 1966-2019. In: Eastern
              Ecological Science Center - Bird Population Studies [Internet].
              2019 [cited 29 Aug 2023]. Available:
              https://www.mbr-pwrc.usgs.gov/
            </p>

            <p>
              North American Bird Conservation Initiative. The State of the
              Birds, United States of America, 2022. 2022. Available:
              https://www.stateofthebirds.org
            </p>
            <p>
              eBird Status and Trends. Data version: 2021. Fink, D., T. Auer, A. Johnston, M. Strimas-Mackey, S. Ligocki, O. Robinson, W. Hochachka, L. Jaromczyk, A. Rodewald, C. Wood, I. Davies, A. Spencer. 2022. eBird Status and Trends, Data Version: 2021; Released: 2022. Cornell Lab of Ornithology, Ithaca, New York. https://doi.org/10.2173/ebirdst.2021
            </p>
            <p class="photo-cred">Photo by Brad Imhoff/Macaulay Library</p>

            <b>Scaled Quail</b>
            <p>
              Zornes M, Bishop RA. Western Quail Management Plan. Williamson SJ,
              editor. Cabot, VT: Wildlife Management Institute; 2009.
            </p>

            <p>
              Dabbert CB, Pleasant G, Schemnitz SD. Conservation and management.
              In: Scaled Quail (Callipepla squamata) [Internet]. 4 Mar 2020
              [cited 29 Aug 2023]. Available:
              https://birdsoftheworld.org/bow/species/scaqua/cur/conservation
            </p>

            <p>
              McIntosh MM, Holechek JL, Spiegal SA, Cibils AF, Estell RE.
              Long-term declining trends in Chihuahuan desert forage production
              in relation to precipitation and ambient temperature. Rangeland
              Ecol Manage. 2019;72: 976–987.
            </p>

            <p>
              U.S. Geological Survey. BBS trends 1966-2019. In: Eastern
              Ecological Science Center - Bird Population Studies [Internet].
              2019 [cited 29 Aug 2023]. Available:
              https://www.mbr-pwrc.usgs.gov/
            </p>
            <p>
              eBird Status and Trends. Data version: 2021. Fink, D., T. Auer, A. Johnston, M. Strimas-Mackey, S. Ligocki, O. Robinson, W. Hochachka, L. Jaromczyk, A. Rodewald, C. Wood, I. Davies, A. Spencer. 2022. eBird Status and Trends, Data Version: 2021; Released: 2022. Cornell Lab of Ornithology, Ithaca, New York. https://doi.org/10.2173/ebirdst.2021
            </p>
            <p class="photo-cred">Photo by Ad Konings</p>

            <b>Greater Sage-Grouse</b>
            <p>
              U.S. Geological Survey. BBS trends 1966-2019. In: Eastern
              Ecological Science Center - Bird Population Studies [Internet].
              2019 [cited 29 Aug 2023]. Available:
              https://www.mbr-pwrc.usgs.gov/
            </p>
            <p class="photo-cred">Photo by Brian Genge/Macaulay Library</p>

            <b>Mallard</b>
            <p>
              Drilling N, Titman RD, McKinney F. Habitat. In: Mallard (Anas
              platyrhynchos) [Internet]. 4 Mar 2020 [cited 30 Aug 2023].
              Available:
              https://birdsoftheworld.org/bow/species/mallar3/cur/habitat
            </p>

            <p>
              Doherty KE, Ryba AJ, Stemler CL, Niemuth ND, Meeks WA.
              Conservation planning in an era of change: state of the U.S.
              Prairie Pothole region. Wildl Soc Bull. 2013. doi:10.1002/wsb.284
            </p>
            <p>
              eBird Status and Trends. Data version: 2021. Fink, D., T. Auer, A. Johnston, M. Strimas-Mackey, S. Ligocki, O. Robinson, W. Hochachka, L. Jaromczyk, A. Rodewald, C. Wood, I. Davies, A. Spencer. 2022. eBird Status and Trends, Data Version: 2021; Released: 2022. Cornell Lab of Ornithology, Ithaca, New York. https://doi.org/10.2173/ebirdst.2021
            </p>
            <p class="photo-cred">Photo by Brad Imhoff/Macaulay Library</p>

            <b>Southern Plains Bumble Bee</b>
            <p>
              Hatfield R, Colla S, Jepsen S, Richardson L, Thorp R, Jordan SF.
              IUCN assessments for North American Bombus spp. Xerces Society;
              2015 Mar.
            </p>
            <p>Xerces Society for Invertebrate Conservation https://www.xerces.org/bumblebees</p>

            <p class="photo-cred">Photo by Clay Bolt</p>

            <b>Mule Deer</b>
            <p>
              Kauffman MJ, Copeland HE, Berg J, Bergen S, Cole E, Cuzzocreo M,
              et al. Ungulate migrations of the western United States, Volume 1:
              U.S. Geological Survey Scientific Investigations Report 2020–5101.
              U.S. Department of the Interior, U.S. Geological Survey; 2020.
              doi:10.3133/sir20205101
            </p>

            <p>
              Kauffman M. World’s longest mule deer migration: Red Desert to
              Hoback. In: USGS [Internet]. 13 Sep 2022 [cited 31 Oct 2023].
              Available: https://geonarrative.usgs.gov/muledeer255/
            </p>

            <p>
              Sawyer H, Middleton AD, Hayes MM, Kauffman MJ, Monteith KL. The
              extra mile: Ungulate migration distance alters the use of seasonal
              range and exposure to anthropogenic risk. Ecosphere. 2016;7:
              e01534.
            </p>
            <p class="photo-cred">Photo by Acton Crawford</p>

            <b>Regal Fritillary</b>
            <p>
              Selby G. Regal Fritillary (Speyeria idalia Drury): a technical
              conservation assessment. USDA Forest Service, Rocky Mountain
              Region; 2007 Feb. Available:
              http://www.fs.fed.us/r2/projects/scp/assessments/regalfritillary.pdf
            </p>

            <p>
              NatureServe explorer 2.0. [cited 30 Aug 2023]. Available:
              https://explorer.natureserve.org/Taxon/ELEMENT_GLOBAL.2.114908/Argynnis_idalia
            </p>
            <p class="photo-cred">Photo by Allen Woodliffe</p>
          </div>
        </div>
        <br />
        <div style="font-size: 12px; font-style: italic">
          <!-- Content here -->
        </div>
      </div>
    </transition>
  </div>
</template>
  
  <script>
export default {
  data() {
    return {
      isOpen: this.isOpenByDefault,
    };
  },
  computed: {
    rotateTransform() {
      return this.isOpen ? "rotate(45deg)" : "rotate(0)";
    },
  },
  methods: {
    toggleAccordion() {
      this.isOpen = !this.isOpen;
    },
  },
};
</script>
  
  <style scoped>
#ref-accordion {
  margin-top: 100px;
}
.flex-container {
  display: flex;
  flex-wrap: wrap;
}

/* create flex class that does not grow */

.flex-icon {
  flex: 0 1 100px;
}

.flex-text {
  flex: 1 1 70%;
}

.accordion {
  margin-top: 10px;
  margin-bottom: 30px;
  border-bottom: 0.5px solid #475026;
}

.accordion-header {
  display: flex;
  align-items: center;
  cursor: pointer;
  font-size: 18px
}

.accordion-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 24px;
  height: 24px;
  margin-right: 10px;
  transition: transform 0.3s;
}

.accordion-icon.open {
  transform: rotate(45deg);
}

.plus {
  font-size: 32px;
  font-weight: normal;
}

.accordion-title {
  font-weight: bold;
}

.accordion-content {
  margin-top: 10px;
}

.accordion-text {
  padding: 10px;
  border-bottom: 1px solid #475026;
  opacity: 0;
  transition: opacity 0.3s;
}

.fade-in {
  opacity: 1;
}

.fade-out {
  opacity: 0;
}

.accordion-transition-enter-active,
.accordion-transition-leave-active {
  transition: height 0.3s, opacity 0.3s;
}

.accordion-transition-enter,
.accordion-transition-leave-to {
  height: 0;
}

.species-circle-small {
  border-radius: 50%;
  width: 100px;
  height: 100px;
  background-size: cover;
  background-position: center;
  background-color: #efead4;
}

.photo-cred {
  font-style: italic;
  margin-bottom: 40px;
}

b {
  font-size: 18px;
}
</style>

  
  