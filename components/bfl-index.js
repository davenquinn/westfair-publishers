import data from "./index-data";
import h from "../styles";
import { nest } from "d3-collection";
import { useState, useMemo } from "react";
import Fuse from "fuse.js";
import dynamic from "next/dynamic";

// Need to dynamically import the form to make sure that styles are resolved correctly
const SearchInput = dynamic(
  () => import("evergreen-ui").then((d) => d.SearchInput),
  { ssr: false }
);

const newData = data.map((d) => {
  return { firstName: d[0], lastName: d[1] };
});

const getSearchResults = (fuse, searchString) => {
  let res = fuse.search(searchString);
  if (searchString.length >= 3) {
    res = res.filter((d) => d.score <= 0.15);
  }
  return res.map((d) => d.item);
};

function BFLIndexContent({ searchString = null }) {
  const fuse = useMemo(() => {
    return new Fuse(newData, {
      keys: [
        { name: "firstName", weight: 1 },
        { name: "lastName", weight: 1 },
      ],
      includeScore: true,
    });
  }, [newData]);

  const filteredData =
    searchString == null || searchString == ""
      ? newData
      : getSearchResults(fuse, searchString);

  const nested = nest()
    .key((d) => d.lastName)
    .entries(filteredData);

  return h(
    "dl",
    nested.map((d) => {
      //const name = d.join(" ");
      return [
        h("dt", d.key),
        h(
          "div.names",
          d.values.map((v) => {
            return h("dd", v.firstName);
          })
        ),
      ];
    })
  );
}

function ByFirstLightIndex() {
  const [searchString, setSearchString] = useState(null);
  return h("div.bfl-index", [
    h("div.bfl-index-header", [
      h("h3", "Search the index: "),
      h(SearchInput, {
        className: "bfl-index-search",
        onChange(e) {
          setSearchString(e.target.value);
        },
        searchString,
      }),
    ]),
    h("div.bfl-index-content", [h(BFLIndexContent, { searchString })]),
  ]);
}

export { ByFirstLightIndex };
