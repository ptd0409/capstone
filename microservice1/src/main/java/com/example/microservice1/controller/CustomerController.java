@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/customers")
public class CustomerController {
    @Autowired
    private CustomerRepository repository;

    @GetMapping
    public List<Customer> all() {
        return repository.findAll();
    }

    @PostMapping
    public Customer create(@RequestBody Customer c) {
        return repository.save(c);
    }
}
