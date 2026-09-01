import './Nav.css'

import logo from '../assets/aabe-dfw-logo.webp'

function Navbar() {
  return (
    <nav className="navbar navbar-expand-lg navbar-light bg-dark px-4">
      <div className="container-fluid">
        <a className="navbar-brand" href="/">
          <img src={logo} alt="AABE DFW Logo" height="40" />
        </a>

        <button
          className="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarNav"
        >
          <span className="navbar-toggler-icon"></span>
        </button>

        <div className="collapse navbar-collapse" id="navbarNav">
          <ul className="navbar-nav ms-auto gap-3">
            <li className="nav-item"><a className="nav-link" href="/">Home</a></li>
            <li className="nav-item"><a className="nav-link" href="/events">Events</a></li>
            <li className="nav-item"><a className="nav-link" href="/committees">Committees</a></li>
            <li className="nav-item"><a className="nav-link" href="/members">Members</a></li>
          </ul>
        </div>
      </div>
    </nav>
  )
}

export default Navbar