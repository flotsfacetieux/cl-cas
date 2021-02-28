(in-package :asdf-user)

(defsystem "cl-cas"
  :name "CL CAS"
  :version "0.0.1"
  :maintainer "Flots Facetieux"
  :author "Flots Facetieux"
  :licence "GPL v3"
  :serial t
  :description "CAS SSO Library."
  :depends-on (:alexandria :dexador :xmls :quri)
  :components ((:module "src"
                :components ((:file "cas")))))
