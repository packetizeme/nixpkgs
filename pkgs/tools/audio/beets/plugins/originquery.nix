{ lib, fetchFromGitHub, beets, python3Packages }:

python3Packages.buildPythonApplication rec {
  pname = "beets-originquery";
  version = "1.0.2";
  pyproject = true;

  src = fetchFromGitHub {
    repo = "beets-originquery";
    owner = "x1ppy";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-i67Bzdh84TuVwcgwo5SgHFp1W04KF3VA6cbrFz82je0=";
  };

  nativeBuildInputs = [
    beets
    python3Packages.poetry-core
    python3Packages.confuse
    python3Packages.jsonpath-rw
    python3Packages.pyyaml
  ];

  nativeCheckInputs = with python3Packages; [
    pytestCheckHook
    pytest-cov
    mock
    typeguard
  ];
  preCheck = ''
    export HOME=$(mktemp -d)
  '';

  meta = with lib; {
    description = "Integrates origin.txt metadata into beets MusicBrainz queries";
    homepage = "https://github.com/x1ppy/beets-originquery";
    maintainers = with maintainers; [ packetizeme ];
    license = licenses.mit;
  };
}
