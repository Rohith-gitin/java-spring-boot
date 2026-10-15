package com.example.ecommerce.web;

import com.example.ecommerce.model.CustomerOrder;
import com.example.ecommerce.model.Product;
import com.example.ecommerce.repository.OrderRepository;
import com.example.ecommerce.service.ProductService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.*;

@Controller
public class StoreController {
    private final ProductService productService;
    private final OrderRepository orderRepository;

    public StoreController(ProductService productService, OrderRepository orderRepository) {
        this.productService = productService;
        this.orderRepository = orderRepository;
    }

    @ModelAttribute("cartCount")
    public int cartCount(HttpSession session) {
        return getCart(session).values().stream().mapToInt(CartItem::getQuantity).sum();
    }

    @GetMapping({"/", "/products"})
    public String home(Model model) {
        model.addAttribute("products", productService.findAll());
        return "products";
    }

    @GetMapping("/products/{id}")
    public String productDetails(@PathVariable Long id, Model model, RedirectAttributes redirect) {
        Optional<Product> product = productService.findById(id);
        if (product.isEmpty()) {
            redirect.addFlashAttribute("error", "Product not found.");
            return "redirect:/";
        }
        model.addAttribute("product", product.get());
        return "product-details";
    }

    @GetMapping("/admin/products")
    public String adminProducts(Model model) {
        model.addAttribute("products", productService.findAll());
        return "admin-products";
    }

    @GetMapping("/admin/products/new")
    public String newProduct(Model model) {
        model.addAttribute("product", new Product());
        model.addAttribute("pageTitle", "Add product");
        return "product-form";
    }

    @GetMapping("/admin/products/{id}/edit")
    public String editProduct(@PathVariable Long id, Model model, RedirectAttributes redirect) {
        Optional<Product> product = productService.findById(id);
        if (product.isEmpty()) {
            redirect.addFlashAttribute("error", "Product not found.");
            return "redirect:/admin/products";
        }
        model.addAttribute("product", product.get());
        model.addAttribute("pageTitle", "Edit product");
        return "product-form";
    }

    @PostMapping("/admin/products/save")
    public String saveProduct(@Valid @ModelAttribute("product") Product product,
                              BindingResult result, Model model, RedirectAttributes redirect) {
        if (result.hasErrors()) {
            model.addAttribute("validationErrors", result.getAllErrors());
            model.addAttribute("pageTitle", product.getId() == null ? "Add product" : "Edit product");
            return "product-form";
        }
        productService.save(product);
        redirect.addFlashAttribute("success", "Product saved successfully.");
        return "redirect:/admin/products";
    }

    @PostMapping("/admin/products/{id}/delete")
    public String deleteProduct(@PathVariable Long id, RedirectAttributes redirect) {
        if (productService.findById(id).isPresent()) {
            productService.deleteById(id);
            redirect.addFlashAttribute("success", "Product deleted.");
        }
        return "redirect:/admin/products";
    }

    @PostMapping("/cart/add/{id}")
    public String addToCart(@PathVariable Long id, HttpSession session, RedirectAttributes redirect) {
        Optional<Product> found = productService.findById(id);
        if (found.isEmpty()) {
            redirect.addFlashAttribute("error", "Product not found.");
            return "redirect:/";
        }
        Product product = found.get();
        if (product.getStock() <= 0) {
            redirect.addFlashAttribute("error", "This product is out of stock.");
            return "redirect:/";
        }
        Map<Long, CartItem> cart = getCart(session);
        CartItem existing = cart.get(id);
        if (existing == null) {
            cart.put(id, new CartItem(product, 1));
        } else if (existing.getQuantity() < product.getStock()) {
            existing.setQuantity(existing.getQuantity() + 1);
        } else {
            redirect.addFlashAttribute("error", "Maximum available stock already in cart.");
            return "redirect:/cart";
        }
        redirect.addFlashAttribute("success", "Added to cart.");
        return "redirect:/cart";
    }

    @GetMapping("/cart")
    public String cart(HttpSession session, Model model) {
        List<CartItem> items = new ArrayList<>(getCart(session).values());
        model.addAttribute("items", items);
        model.addAttribute("total", cartTotal(items));
        return "cart";
    }

    @PostMapping("/cart/update/{id}")
    public String updateCart(@PathVariable Long id, @RequestParam int quantity,
                             HttpSession session, RedirectAttributes redirect) {
        Map<Long, CartItem> cart = getCart(session);
        CartItem item = cart.get(id);
        if (item != null) {
            if (quantity <= 0) {
                cart.remove(id);
            } else {
                int stock = productService.findById(id).map(Product::getStock).orElse(0);
                if (quantity > stock) {
                    redirect.addFlashAttribute("error", "Quantity exceeds available stock.");
                    return "redirect:/cart";
                }
                item.setQuantity(quantity);
            }
        }
        return "redirect:/cart";
    }

    @PostMapping("/cart/remove/{id}")
    public String removeFromCart(@PathVariable Long id, HttpSession session) {
        getCart(session).remove(id);
        return "redirect:/cart";
    }

    @GetMapping("/checkout")
    public String checkout(HttpSession session, Model model, RedirectAttributes redirect) {
        List<CartItem> items = new ArrayList<>(getCart(session).values());
        if (items.isEmpty()) {
            redirect.addFlashAttribute("error", "Your cart is empty.");
            return "redirect:/cart";
        }
        model.addAttribute("items", items);
        model.addAttribute("total", cartTotal(items));
        return "checkout";
    }

    @PostMapping("/checkout")
    public String placeOrder(@RequestParam String customerName, @RequestParam String email,
                             @RequestParam String shippingAddress, HttpSession session,
                             Model model, RedirectAttributes redirect) {
        List<CartItem> items = new ArrayList<>(getCart(session).values());
        if (items.isEmpty()) {
            redirect.addFlashAttribute("error", "Your cart is empty.");
            return "redirect:/cart";
        }
        if (customerName == null || customerName.isBlank() || email == null || email.isBlank()
                || shippingAddress == null || shippingAddress.isBlank()) {
            model.addAttribute("items", items);
            model.addAttribute("total", cartTotal(items));
            model.addAttribute("error", "Please fill in all checkout fields.");
            return "checkout";
        }
        for (CartItem item : items) {
            Product current = productService.findById(item.getProduct().getId()).orElse(null);
            if (current == null || current.getStock() < item.getQuantity()) {
                model.addAttribute("items", items);
                model.addAttribute("total", cartTotal(items));
                model.addAttribute("error", "Stock changed for " + item.getProduct().getName()
                        + ". Please review your cart.");
                return "checkout";
            }
        }
        BigDecimal total = cartTotal(items);
        CustomerOrder order = orderRepository.save(
                new CustomerOrder(customerName.trim(), email.trim(), shippingAddress.trim(), total));
        for (CartItem item : items) {
            Product current = productService.findById(item.getProduct().getId()).orElseThrow();
            current.setStock(current.getStock() - item.getQuantity());
            productService.save(current);
        }
        session.removeAttribute("cart");
        redirect.addFlashAttribute("orderId", order.getId());
        redirect.addFlashAttribute("orderTotal", total);
        return "redirect:/order-success";
    }

    @GetMapping("/order-success")
    public String orderSuccess() {
        return "order-success";
    }

    private Map<Long, CartItem> getCart(HttpSession session) {
        @SuppressWarnings("unchecked")
        Map<Long, CartItem> cart = (Map<Long, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    private BigDecimal cartTotal(List<CartItem> items) {
        return items.stream().map(CartItem::getSubtotal).reduce(BigDecimal.ZERO, BigDecimal::add);
    }
}
