import React, {Children} from 'react'
import Link from 'next/link'
import { useRouter } from 'next/router'
import { Button } from "evergreen-ui";
import classNames from 'classnames'
import h from '../styles'

links = [
  { href: '/always-with-spirit', label: 'Always With Spirit', className: "book" },
  { href: '/by-first-light', label: 'By First Light', className: "book" },
  { href: '/how-to-order', label: 'How to order' },
  { href: '/contact', label: 'Contact' },
].map (link)->
  link.key = "nav-link-#{link.href}-#{link.label}"
  return link


# Class to make an activeLink
ActiveLink = ({children, ...props }) ->
  router = useRouter()
  child = Children.only(children)
  className = child.props.className or ''
  isActive = router.pathname == props.href
  className = classNames(child.props.className, {"active": isActive})
  return h Link, props, React.cloneElement(child, { className })

Nav = ->
  h 'nav', [
    h 'ul', links.map ({ key, href, label, className }) ->
      className ?= ""
      h 'li', {key}, [
        h ActiveLink, {href}, [
          h 'a.link-button', {className}, label
        ]
      ]
  ]

BaseLink = (props)->
  h Link, {href: "/"}, [
    h 'a', props
  ]

SiteTitle = (props)->
  h BaseLink, [
    h 'h1.site-title', props
  ]

LinkButton = ({href, children = "Learn more"})->
  h Link, {href}, [
    h "a.link-button", children
  ]

export {BaseLink, SiteTitle, Nav, LinkButton}
