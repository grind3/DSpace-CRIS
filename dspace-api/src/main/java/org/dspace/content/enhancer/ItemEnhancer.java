/**
 * The contents of this file are subject to the license and copyright
 * detailed in the LICENSE and NOTICE files at the root of the source
 * tree and available online at
 *
 * http://www.dspace.org/license/
 */
package org.dspace.content.enhancer;

import org.dspace.content.Item;
import org.dspace.core.Context;

/**
 * The enhancers allow to add metadata to the item so that additional
 * information can be associated with it.
 *
 * @author Luca Giamminonni (luca.giamminonni at 4science.it)
 *
 */
public interface ItemEnhancer {

    public static final String VIRTUAL_METADATA_SCHEMA = "cris";
    public static final String VIRTUAL_METADATA_ELEMENT = "virtual";
    public static final String VIRTUAL_SOURCE_METADATA_ELEMENT = "virtualsource";

    /**
     * Check if the given item can be enhanced.
     *
     * @param  context the DSpace Context
     * @param  item    the item to check
     * @return         true if the given item can be enhanced, false otherwise
     */
    boolean canEnhance(Context context, Item item);

    /**
     * Enhances the metadata of the given item according to a specific logic. The
     * added metadata have the form cris.virtual.<qualifier>, where <qualifier> is
     * set arbitrarily based on the strategy used. In addition, metadata of the type
     * cris.virtualsource.<qualifier> can be added to specify the source of the
     * enhancement. Multiple metadata values can be added on the given item. This
     * method returns true if the given item's metadata values are changed. The
     * enhancement is idempotent: multiple invocations on the same item must not
     * produce metadata different from those that would be obtained with a single
     * invocation. The only difference between multiple invocations of this method
     * is that the first one may return true while all the others false, since the
     * enhancement will actually only be done the first time.
     *
     * @param  context the DSpace Context
     * @param  item    the item to enhance
     * @return         true if the given item's metadata values are changed, false
     *                 otherwise
     */
    boolean enhance(Context context, Item item);
}
