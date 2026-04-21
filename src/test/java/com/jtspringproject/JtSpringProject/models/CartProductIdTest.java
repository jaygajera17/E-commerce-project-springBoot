package com.jtspringproject.JtSpringProject.models;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CartProductIdTest {

    @Test
    void testConstructorAndGetters() {
        CartProductId id = new CartProductId(1, 2);

        assertEquals(1, id.getCartId());
        assertEquals(2, id.getProductId());
    }

    @Test
    void testSetters() {
        CartProductId id = new CartProductId();
        id.setCartId(5);
        id.setProductId(10);

        assertEquals(5, id.getCartId());
        assertEquals(10, id.getProductId());
    }

    @Test
    void testEqualsAndHashCode() {
        CartProductId id1 = new CartProductId(1, 2);
        CartProductId id2 = new CartProductId(1, 2);
        CartProductId id3 = new CartProductId(2, 3);

        assertEquals(id1, id2);
        assertNotEquals(id1, id3);

        assertEquals(id1.hashCode(), id2.hashCode());
        assertNotEquals(id1.hashCode(), id3.hashCode());
    }

    @Test
    void testNotEqualsWithNullOrDifferentType() {
        CartProductId id = new CartProductId(1, 2);
        assertNotEquals(null, id);
        assertNotEquals("string", id);
    }
}
