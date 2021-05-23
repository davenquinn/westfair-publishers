import data from "./index-data";
import h from "../styles";
import { nest } from "d3-collection";
import { SearchInput } from "evergreen-ui";
import { useState, useRef, useMemo } from "react";
import Fuse from "fuse.js";

const newData = data.map((d) => {
  return { firstName: d[0], lastName: d[1] };
});

function BFLIndexContent({ searchString = null }) {
  const fuse = useMemo(() => {
    return new Fuse(newData, {
      keys: [
        { name: "firstName", weight: 1 },
        { name: "lastName", weight: 2 },
      ],
    });
  }, [newData]);

  const filteredData =
    searchString == null || searchString == ""
      ? newData
      : fuse.search(searchString).map((d) => d.item);

  const nested = nest()
    .key((d) => d.lastName)
    .entries(filteredData);

  return h(
    "dl",
    nested.map((d) => {
      //const name = d.join(" ");
      return [
        h("dt", d.key),
        d.values.map((v) => {
          return h("dd", v.firstName);
        }),
      ];
    })
  );
}

function ByFirstLightIndex() {
  const [searchString, setSearchString] = useState(null);
  return h("div.bfl-index", [
    h(SearchInput, {
      onChange(e) {
        console.log(e.target.value);
        setSearchString(e.target.value);
      },
      searchString,
    }),
    h("div.bfl-index-content", [h(BFLIndexContent, { searchString })]),
  ]);
}

export { ByFirstLightIndex };
