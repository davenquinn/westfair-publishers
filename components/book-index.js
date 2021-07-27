import bflData from "./bfl-index-data";
import awsData from "./aws-index-data";
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

const getSearchResults = (fuse, searchString) => {
  let res = fuse.search(searchString);
  if (searchString.length >= 3) {
    res = res.filter((d) => d.score <= 0.15);
  }
  return res.map((d) => d.item);
};

function BookIndexContent({ data, searchString = null }) {
  const fuse = useMemo(() => {
    return new Fuse(data, {
      keys: [
        { name: "firstName", weight: 1 },
        { name: "lastName", weight: 1 },
      ],
      includeScore: true,
    });
  }, [data]);

  const filteredData =
    searchString == null || searchString == ""
      ? data
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

function BookIndex({ data, id }) {
  const newData = data.map((d) => {
    return { firstName: d[0], lastName: d[1] };
  });

  const [searchString, setSearchString] = useState(null);
  return h(`div.index.${id}-index`, [
    h(`div.index-header.${id}-index-header`, [
      h("h3", "Search the index: "),
      h(SearchInput, {
        className: `index-search ${id}-index-search`,
        onChange(e) {
          setSearchString(e.target.value);
        },
        searchString,
      }),
    ]),
    h(`div.${id}-index-content.index-content`, [
      h(BookIndexContent, { searchString, data: newData }),
    ]),
  ]);
}

function ByFirstLightIndex() {
  return h(BookIndex, { id: "bfl", data: bflData });
}

function AWSIndex() {
  return h(BookIndex, { id: "aws", data: awsData });
}

export { ByFirstLightIndex };
