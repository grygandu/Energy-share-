;; ----------------------------------------------
;; Project: EnergyShare - Decentralized Energy Trading
;; Description: Peer-to-peer renewable energy credit exchange on Stacks.
;; ----------------------------------------------

(define-constant contract-owner 'SP2J6ZY48GV1EZ5V2V5RB9MP66SW86PYKKNRV9EJ7) ;; Contract owner principal

(define-fungible-token energy-credit) ;; Define the fungible token
(define-constant TOKEN-DECIMALS u6)

(define-data-var total-supply uint u0)
(define-data-var price-per-unit uint u10) ;; price in STX per energy unit
(define-map balances {user: principal} {amount: uint})
(define-map sales {seller: principal} {amount: uint, price: uint})

;; ----------------------------------------------
;; MINT ENERGY TOKENS (Producers)
;; ----------------------------------------------
(define-public (mint-energy (amount uint))
    (begin
        (asserts! (> amount u0) (err u0))
        (try! (ft-mint? energy-credit amount tx-sender))
        (ok amount)
    )
)

;; ----------------------------------------------
;; LIST ENERGY FOR SALE
;; ----------------------------------------------
(define-public (list-energy (amount uint) (price uint))
    (begin
        (asserts! (> amount u0) (err u0))
        (asserts! (> price u0) (err u0))
        (try! (ft-transfer? energy-credit amount tx-sender (as-contract tx-sender)))
        (map-set sales {seller: tx-sender} {amount: amount, price: price})
        (ok amount)
    )
)

;; ----------------------------------------------
;; BUY ENERGY
;; ----------------------------------------------
(define-public (buy-energy (seller principal))
    (let ((sale (map-get? sales {seller: seller})))
        (match sale
            s
            (let ((cost (* (get amount s) (get price s))))
                (begin
                    (try! (stx-transfer? cost tx-sender seller))
                    (try! (ft-transfer? energy-credit (get amount s) (as-contract tx-sender) tx-sender))
                    (map-delete sales {seller: seller})
                    (ok (get amount s))
                )
            )
            (err u0)
        )
    )
)

;; ----------------------------------------------
;; CHECK BALANCE
;; ----------------------------------------------
(define-read-only (get-balance (user principal))
    (ok (ft-get-balance energy-credit user))
)

;; ----------------------------------------------
;; UPDATE PRICE (Admin Control)
;; ----------------------------------------------
(define-public (update-price (new-price uint))
    (begin
        (asserts! (is-eq tx-sender contract-owner) (err u0))
        (var-set price-per-unit new-price)
        (ok new-price)
    )
)
